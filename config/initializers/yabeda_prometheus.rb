# frozen_string_literal: true
Yabeda::Prometheus::Exporter.start_metrics_server! unless Rails.env.test?
