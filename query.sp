query "workload_risk_by_pillar" {
  sql = <<-EOQ
    select
        a.risk,
        count(a.risk)
    from
        aws_wellarchitected_answer a
    where
        a.workload_id = $1
        and
        a.pillar_id = $2
    group by
        a.risk
    EOQ
  param "workload_id" {
    default = "9c46e9dd321a48988bd52cffea857e8a"
  }
  param "pillar_id" {
    default = "operationalExcellence"
  } 
}

query "media_total_risk" {
  sql = <<-EOT
    select
      risk,
      round(AVG(subquery.total_risk))  as media_total_risk
    from
      (
      select
        a.workload_id,
        a.pillar_id,
        a.risk,
        COUNT(a.risk) as total_risk
      from
        aws_wellarchitected_answer a
      group by
        a.workload_id,
        a.pillar_id,
        a.risk
    ) as subquery
    where
        workload_id not in ('289b9872a1f5f8d985bccd918596017e', '289b9872a1f5f8d985bccd918596017e')
      and
        pillar_id = $1
      and
        risk IN ('HIGH', 'MEDIUM', 'NONE')
    group by
        pillar_id,
        risk;
  EOT
  param "pillar" {
    default = "operationalExcellence"
  } 
}

query "benchmark_risk" {
  sql = <<-EOT
    select
      pillar_id,
      risk,
      round(AVG(subquery.total_risk))  as media_total_risk
    from
      (
      select
        a.workload_id,
        a.pillar_id,
        a.risk,
        COUNT(a.risk) as total_risk
      from
        aws_wellarchitected_answer a
      group by
        a.workload_id,
        a.pillar_id,
        a.risk
    ) as subquery
    where
        pillar_id not in ('COST', 'DEL', 'OPINT', 'OPS', 'PERF', 'REL', 'SEC', 'architecture', 'event_management', 'PREP', 'SUS', 'release_quality')
      and
        risk = $1
    group by
        pillar_id,
        risk;
  EOT
  param "risk" {
    default = "HIGH"
  } 
}