chart "media_total_risk" {
    type = "donut"
    title = "Excelencia Operacional"

    series "media_total_risk" {
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

    legend {
        display = "all"
        position = "bottom"
    }
    
    query = query.media_total_risk
    args = {
        "pillar" = "operationalExcellence"
    }
    width = 2
}

chart "benchmark_risk"{
    type = "column"
    series "MEDIUM" {
        title = "Medium"
        color = "#ffab40"
    }
    query = query.benchmark_risk
}

chart "workload_risk_by_pillar"{
    type  = "donut"
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
    query = query.workload_risk_by_pillar
}