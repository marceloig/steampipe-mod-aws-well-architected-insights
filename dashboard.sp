dashboard "workload_dashboard" {

  title = "Well Architected Review"

  container {
    title = "Visão Geral do Well-Architected Framework"

    chart {
      type  = "donut"
      title = "Question Overview"
      series "count" {
        point "HIGH" {
          color = "alert"
        }
        point "MEDIUM" {
          color = "#ffab40"
        }
        point "NONE" {
          color = "ok"
        }
      }
      sql = <<-EOQ
        select
            a.risk,
            count(a.risk)
        from
            aws_wellarchitected_answer a
        where
            a.workload_id = '9c46e9dd321a48988bd52cffea857e8a'
        group by
            a.risk
      EOQ
      width = 6
    }
    chart {
      type  = "donut"
      title = "Items Overview"
      series "count" {
        point "HIGH" {
          color = "alert"
        }
        point "MEDIUM" {
          color = "#ffab40"
        }
        point "NONE" {
          color = "ok"
        }
      }
      sql = <<-EOQ
        select
            a.risk,
            count(a.risk)
        from
            aws_wellarchitected_answer a,
            jsonb_array_elements(choices) c
        where
            a.workload_id = '9c46e9dd321a48988bd52cffea857e8a'
        group by
            a.risk
      EOQ
      width = 6
    }
  }
  
  container {

    chart {
      base = chart.workload_risk_by_pillar
      title = "Excelencia Operacional"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "operationalExcellence"
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Segurança"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "security"
      }
      width = 2
    }
    chart {
      base = chart.workload_risk_by_pillar
      title = "Confiabilidade"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "reliability"
      }
      width = 2
    }
    chart {
      base = chart.workload_risk_by_pillar
      title = "Eficiencia de Perfomance"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "performance"
      }
      width = 2
    }
    chart {
      base = chart.workload_risk_by_pillar
      title = "Otimização de Custo"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "costOptimization"
      }
      width = 2
    }
    chart {
      base = chart.workload_risk_by_pillar
      title = "Sustentabilidade"
      args = {
        "workload_id" = "9c46e9dd321a48988bd52cffea857e8a"
        "pillar_id" = "sustainability"
      }
      width = 2
    }
  }
}

dashboard "benchmark_dashboard" {

  title = "Benchmark Well Architected"

  container {
    title = "Benchmark de Pilares"

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "operationalExcellence"
      }
      width = 2
    }

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "security"
      }
      width = 2
    }

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "reliability"
      }
      width = 2
    }

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "performance"
      }
      width = 2
    }

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "costOptimization"
      }
      width = 2
    }

    chart {
      base = chart.media_total_risk
      args = {
        "pillar" = "sustainability"
      }
      width = 2
    }

  }

  container {
    title = "Benchmark de High Risk"

    chart {
      base = chart.benchmark_risk
      title = "High Risk por Pilar"
      args = {
        "risk" = "HIGH"
      }
      width = 12
    }

  }

  container {
    title = "Benchmark de Medium Risk"

    chart {
      base = chart.benchmark_risk
      title = "Medium Risk por Pilar"
      args = {
        "risk" = "MEDIUM"
      }
      width = 12
    }

  }
}