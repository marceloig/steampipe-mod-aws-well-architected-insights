chart "risk_by_pillar" {
    type = "donut"

    series "value" {
        point "HIGH" {
            color = "alert"
        }
        point "MEDIUM" {
            color = "#FF9900"
        }
        point "NONE" {
            color = "ok"
        }
        point "UNANSWERED" {
            color = "gray"
        }
    }

    legend {
        display = "all"
        position = "bottom"
    }
    
    query = query.media_total_risk
    width = 2
}

chart "benchmark_risk"{
    type = "column"
    query = query.benchmark_risk
}

chart "workload_risk_by_pillar"{
    type  = "donut"
    series "value" {
        point "HIGH" {
            color = "alert"
        }
        point "MEDIUM" {
            color = "#FF9900"
        }
        point "NONE" {
            color = "ok"
        }
        point "UNANSWERED" {
            color = "gray"
        }
    }
    query = query.workload_risk_by_pillar
}

chart "chart_overview"{
    type  = "donut"
    series "value" {
        point "HIGH" {
            color = "alert"
        }
        point "MEDIUM" {
            color = "#FF9900"
        }
        point "NONE" {
            color = "ok"
        }
        point "UNANSWERED" {
            color = "gray"
        }
    }
    query = query.workload_risk_by_pillar
}