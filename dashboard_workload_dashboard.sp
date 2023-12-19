dashboard "workload_dashboard" {
  title = "Well Architected Review"

  input "workload_id" {
    title = "Select a workload:"
    query = query.wellarchitected_workload_input
    width = 4
  }

  input "lens_alias" {
    title = "Select one or more lens:"
    query = query.wellarchitected_lens_input
    type = "multiselect"
    width = 4
  }

  container {
    card {
      query = query.risk_counts
      type  = "alert"
      label = "High Risks"
      width = 2
      args = {
        "label" = "High Risks"
        "risk" = "HIGH"
        "workload_id" = self.input.workload_id.value
      }
    }
    card {
      query = query.risk_counts
      type  = "info"
      width = 2
      args = {
        "label" = "Medium Risks"
        "risk" = "MEDIUM"
        "workload_id" = self.input.workload_id.value
      }
    }
    card {
      query = query.risk_counts
      type  = "ok"
      width = 2
      args = {
        "label" = "Resolved"
        "risk" = "NONE"
        "workload_id" = self.input.workload_id.value
      }
    }
  }

  container {
    title = "Visão Geral do Well-Architected Framework"

    chart {
      base = chart.chart_overview
      title = "Question Overview"
      query = query.question_overview
      width = 6
      args = {
        "workload_id" = self.input.workload_id.value
      }
    }
    chart {
      base = chart.chart_overview
      title = "Items Overview"
      query = query.items_overview
      width = 6
      args = {
        "workload_id" = self.input.workload_id.value
      }
    }
  }
  
  container {

    chart {
      base = chart.workload_risk_by_pillar
      title = "Cost Optimization"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "costOptimization"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Operational Excellence"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "operationalExcellence"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Performance Efficiency"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "performance"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Reliability"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "reliability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Security"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "security"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.workload_risk_by_pillar
      title = "Sustainability"
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "sustainability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }
  }
  container {
    title = "Benchmark de Questões do WA Framework"

    chart {
      base = chart.chart_overview
      title = "Workload"
      query = query.question_overview
      width = 6
      args = {
        "workload_id" = self.input.workload_id.value
      }
    }

    chart {
      base = chart.chart_overview
      title = "Benchmark"
      query = query.benchmark_question_overview
      width = 6
      args = {
        "lens_alias" = self.input.lens_alias.value
      }
    }
  }

  container {
    title = "Benchmark Geral de Pilares"
    chart {
      base = chart.risk_by_pillar
      title = "Excelencia Operacional"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "operationalExcellence"
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Segurança"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "security"
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Confiabilidade"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "reliability"
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Eficiencia de Perfomance"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "performance"
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Otimização de Custo"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "costOptimization"
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Sustentabilidade"
      query = query.workload_risks_by_pillar
      args = {
        "workload_id" = self.input.workload_id.value
        "pillar_id" = "sustainability"
      }
      width = 2
    }
  }

  container {
    chart {
      base = chart.risk_by_pillar
      title = "Excelencia Operacional"
      args = {
        "pillar" = "operationalExcellence"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Segurança"
      args = {
        "pillar" = "security"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Confiabilidade"
      args = {
        "pillar" = "reliability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Eficiencia de Perfomance"
      args = {
        "pillar" = "performance"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Otimização de Custo"
      args = {
        "pillar" = "costOptimization"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Sustentabilidade"
      args = {
        "pillar" = "sustainability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }
  }

}