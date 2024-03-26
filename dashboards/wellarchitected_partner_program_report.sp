// Risk types from aws_wellarchitected_workload are not returned if their count is 0, so use coalesce(..., 0)
// But from aws_wellarchitected_lens_review, all risk types are returned even when their count is 0
dashboard "wellarchitected_partner_program_report" {

  title = "AWS Well-Architected Partner Program Report"

  tags = merge(local.wellarchitected_common_tags, {
    type = "Report"
  })

  container {

    card {
      query = query.wellarchitected_review_total_this_year
      width = 2
      icon  = "hashtag"
    }

  }

  container {

    chart {
      type = "line"
      title = "Review this year by months"
      width = 12
      query = query.wellarchitected_review_by_months 
    }

  }

  container {

    table {
      width = 12
      title = "Workload this year"
      query = query.wellarchitected_workload_this_year
    }

  }

}

query "wellarchitected_review_by_months" {
  sql = <<-EOQ
    with latest_milestones as (
      select
        max(milestone_number) as milestone_number,
        workload_id
      from
        aws_wellarchitected_milestone
      where
        date_part('year',
        recorded_at) = date_part('year',
        now())
      group by
        workload_id
    )

      select
        TO_CHAR(
          TO_DATE (date_part('month',
        m.recorded_at)::text,
        'MM'),
        'Month'
          ) as "Month",
        count(date_part('month', m.recorded_at)) as "Total"
      from
        aws_wellarchitected_milestone m,
        latest_milestones l
      where
        m.milestone_number = l.milestone_number
        and m.workload_id = l.workload_id
      group by
        date_part('month',
        m.recorded_at)
  EOQ
}

query "wellarchitected_review_total_this_year" {
  sql = <<-EOQ
    with latest_milestones as (
      select
        max(milestone_number) as milestone_number,
        workload_id
      from
        aws_wellarchitected_milestone
      where
        date_part('year',
        recorded_at) = date_part('year',
        now())
      group by
        workload_id
      )

      select
        'Total review this year' as label,
        count(*) as value
      from
        aws_wellarchitected_milestone m,
        latest_milestones l
      where
        m.milestone_number = l.milestone_number
        and m.workload_id = l.workload_id
  EOQ
}

query "wellarchitected_workload_this_year" {
  sql = <<-EOQ
    with latest_milestones as (
      select
        max(milestone_number) as milestone_number,
        workload_id
      from
        aws_wellarchitected_milestone
      where
        date_part('year',
        recorded_at) = date_part('year',
        now())
      group by
        workload_id
    )

      select
        w.workload_name,
        w.workload_arn,
        m.recorded_at 
      from
        aws_wellarchitected_workload as w,
        aws_wellarchitected_lens_review as lr,
        latest_milestones as lm,
        aws_wellarchitected_milestone m
      where
        w.workload_id = lr.workload_id
        and
        lm.workload_id = w.workload_id
        and
        m.milestone_number = lm.milestone_number
        and 
        m.workload_id = lm.workload_id
        and 
        lr.lens_alias = 'wellarchitected'
      order by
        m.recorded_at desc
  EOQ
}