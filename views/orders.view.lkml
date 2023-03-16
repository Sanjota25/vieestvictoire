# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  #sql_table_name: "LOOKER_TEST_BACKUP"."ORDERS"
   # ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.




  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "ID" in Explore.

  dimension: id {
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}."ORDER_AMOUNT" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_order_amount {
    type: sum
    sql: ${order_amount} ;;
  }

  measure: average_order_amount {
    type: average
    sql: ${order_amount} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
    link: {
      label: "Drill"
      url: "
      {% assign vis_config = '{
      [\"x_axis_gridlines\":true,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"ordering\":\"none\",\"show_null_labels\":false,\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\",\"series_types\":{},\"type\":\"looker_column\",\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":12,\"rows_font_size\":12,\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"defaults_version\":1]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }



  measure: count {
    type: count_distinct
    sql: 1=1 ;;
    drill_fields: [status]
  }
}
