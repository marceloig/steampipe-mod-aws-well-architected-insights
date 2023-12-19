dashboard "benchmark_dashboard" {

  title = "Benchmark Well Architected"

  input "lens_alias" {
    title = "Select one or more lens:"
    query = query.wellarchitected_lens_input
    type = "multiselect"
    width = 4
  }

  container {
    card {
      query = query.benchmark_risk_counts
      type  = "alert"
      width = 2
      args = {
        "risk" = "HIGH"
        "label" = "High Risks"
        "lens_alias" = self.input.lens_alias.value
      }
    }
    card {
      query = query.benchmark_risk_counts
      type  = "info"
      width = 2
      args = {
        "risk" = "MEDIUM"
        "label" = "Medium Risks"
        "lens_alias" = self.input.lens_alias.value
      }
    }
    card {
      query = query.benchmark_risk_counts
      type  = "ok"
      width = 2
      args = {
        "risk" = "NONE"
        "label" = "Resolved"
        "lens_alias" = self.input.lens_alias.value
      }
    }
  }

  container {
    title = "Benchmark de Pilares"

    chart {
      base = chart.risk_by_pillar
      title = "Cost Optimization"
      args = {
        "pillar" = "costOptimization"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Operational Excellence"
      args = {
        "pillar" = "operationalExcellence"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Performance Efficiency"
      args = {
        "pillar" = "performance"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Reliability"
      args = {
        "pillar" = "reliability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Security"
      args = {
        "pillar" = "security"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

    chart {
      base = chart.risk_by_pillar
      title = "Sustainability"
      args = {
        "pillar" = "sustainability"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 2
    }

  }

  container {
    title = "Benchmark de High Risk"

    chart {
      base = chart.benchmark_risk
      title = "High Risk por Pilar"
      series "HIGH" {
        title = "High"
        color = "alert"
      }
      args = {
        "risk" = "HIGH"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 12
    }

  }

  container {
    title = "Benchmark de Medium Risk"

    chart {
      base = chart.benchmark_risk
      title = "Medium Risk por Pilar"
      series "MEDIUM" {
        title = "Medium"
        color = "#FF9900"
      }
      args = {
        "risk" = "MEDIUM"
        "lens_alias" = self.input.lens_alias.value
      }
      width = 12
    }

  }
} 