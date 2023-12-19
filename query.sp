query "workload_risk_by_pillar" {
  sql = <<-EOQ
    select
        a.risk,
        count(a.risk) as value
    from
        aws_wellarchitected_answer a
    where
        a.workload_id = $1
      and
        a.pillar_id = $2
      and
        a.lens_alias = any(string_to_array($3, ','))
    group by
        a.risk
    EOQ
  param "workload_id" {
    default = "9c46e9dd321a48988bd52cffea857e8a"
  }
  param "pillar_id" {
    default = "operationalExcellence"
  }
  param "lens_alias" {
    default = ["wellarchitected"]
  }
}

query "media_total_risk" {
  sql = <<-EOT
    select
      'HIGH' as risk,
      ROUND(AVG((s -> 'RiskCounts' ->> 'HIGH')::int)) as value
    from
      aws_wellarchitected_lens_review
    join JSONB_ARRAY_ELEMENTS(pillar_review_summaries) as s on
      true
    where
      s ->> 'PillarId' = $1
      and lens_alias = any(string_to_array($2,
      ','))
   
    union all

    select
      'MEDIUM' as risk,
      ROUND(AVG((s -> 'RiskCounts' ->> 'MEDIUM')::int)) as value
    from
      aws_wellarchitected_lens_review
    join JSONB_ARRAY_ELEMENTS(pillar_review_summaries) as s on
      true
    where
      s ->> 'PillarId' = $1
      and lens_alias = any(string_to_array($2,
      ','))
    
    union all

    select
      'NONE' as risk,
      ROUND(AVG((s -> 'RiskCounts' ->> 'NONE')::int)) as value
    from
      aws_wellarchitected_lens_review
    join JSONB_ARRAY_ELEMENTS(pillar_review_summaries) as s on
      true
    where
      s ->> 'PillarId' = $1
      and lens_alias = any(string_to_array($2,
      ','))
  EOT
  param "pillar" {
    default = "operationalExcellence"
  }
  param "lens_alias" {
    default = ["wellarchitected"]
  }
}

query "benchmark_risk" {
  sql = <<-EOT
    select
      s ->> 'PillarName' as pillar_name,
      $1 as risk,
      round(avg((s -> 'RiskCounts' ->> $1) :: int)) as value
    from
      aws_wellarchitected_lens_review,
      jsonb_array_elements(pillar_review_summaries) as s
    where
      lens_alias = any(string_to_array($2,
      ','))
    group by 
      s ->> 'PillarName'
  EOT
  param "risk" {}
  param "lens_alias" {}
}

query "benchmark_question_overview" {
  sql = <<-EOT
    select
      risk,
      round(AVG(subquery.total_risk)) as value
    from
      (
      select
        a.workload_id,
        a.lens_alias,
        a.risk,
        COUNT(a.risk) as total_risk
      from
        aws_wellarchitected_answer a
      group by
        a.workload_id,
        a.lens_alias,
        a.risk,
        a.lens_alias
    ) as subquery
    where
      	lens_alias = any(string_to_array($1, ','))
    group by
        risk;
  EOT
  param "lens_alias" {
    default = ["wellarchitected"]
  }
}

query "question_overview" {
  sql = <<-EOQ
    select
        a.risk,
        count(a.risk) as value
    from
        aws_wellarchitected_answer a
    where
        a.workload_id = $1
    group by
        a.risk
  EOQ
  param "workload_id" {
    default = "9c46e9dd321a48988bd52cffea857e8a"
  }
}

query "items_overview" {
  sql = <<-EOQ
    select
        a.risk,
        count(a.risk) as value
    from
        aws_wellarchitected_answer a,
        jsonb_array_elements(choices) c
    where
        a.workload_id = $1
    group by
        a.risk
  EOQ
  param "workload_id" {
    default = "9c46e9dd321a48988bd52cffea857e8a"
  }
}

query "risk_counts" {
  sql = <<-EOQ
    select
      $1 as label,
      risk_counts -> $2 as value
    from
      aws_wellarchitected_workload
    where
        workload_id = $3
  EOQ
  param "label" {
    default = "Risks"
  }
  param "risk" {
    default = "HIGH"
  }
  param "workload_id" {
    default = "9c46e9dd321a48988bd52cffea857e8a"
  }
}

query "benchmark_risk_counts" {
  sql = <<-EOQ
    select
      $1 as label,
      round(avg((risk_counts -> $2) :: int)) as value
    from
      aws_wellarchitected_lens_review
    where
      lens_alias = any(string_to_array($3,
      ','))
  EOQ
  param "label" {}
  param "risk" {}
  param "lens_alias" {
    default = ["wellarchitected"]
  }
}

query "workload_risks_by_pillar" {
  sql = <<-EOQ
    select
        a.risk,
        count(a.risk) as value
    from
        aws_wellarchitected_answer a
    where
        a.workload_id = $1
      and
        a.pillar_id = $2
    group by
        a.risk
  EOQ
  param "workload_id" {}
  param "pillar_id" {}
}


query "wellarchitected_workload_input" {
  sql = <<-EOQ
    select
      title as label,
      workload_id as value,
      json_build_object(
        'account_id', account_id,
        'region', region
      ) as tags
    from
      aws_wellarchitected_workload
    order by
      title;
  EOQ
}

query "wellarchitected_lens_input" {
  sql = <<-EOQ
    select
      arn,
      lens_name as label,
      lens_alias as value,
      json_build_object(
        'lens_type',
      lens_type,
      'updated_at',
      updated_at
      ) as tags
    from
      aws_wellarchitected_lens
    order by
      case
        arn when 'arn:aws:wellarchitected::aws:lens/wellarchitected' then 0
        else 1
      end,
      arn
  EOQ
}