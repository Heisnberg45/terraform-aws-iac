resource "aws_cloudwatch_dashboard" "example" {
  dashboard_name = "EC2MonitoringDashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["MyCustomNamespace", "cpu_usage_idle", "InstanceId", "${module.ec2_instance.instance_id}"],
            [".", "cpu_usage_user", ".", "."],
            [".", "cpu_usage_system", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "eu-north-1"
          title   = "EC2 CPU Usage"
          period  = 60
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["MyCustomNamespace", "mem_used_percent", "InstanceId", "${module.ec2_instance.instance_id}"]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "eu-north-1"
          title   = "EC2 Memory Usage"
          period  = 60
        }
      }
    ]
  })
}
