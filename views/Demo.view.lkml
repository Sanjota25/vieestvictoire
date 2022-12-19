view: demo {

    sql_table_name: demo_db.products ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: brand {
      type: string
      sql: ${TABLE}.brand ;;
    }

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    dimension: department {
      type: string
      sql: ${TABLE}.department ;;
    }

    dimension: item_name {
      type: string
      sql: ${TABLE}.item_name ;;
    }

    dimension: rank {
      type: number
      sql: ${TABLE}.rank ;;
      html: {{rendered_value | minus: retail_price}} ;;
    }

    dimension: retail_price {
      type: number
      sql: ${TABLE}.retail_price ;;
    }


    dimension: sku {
      type: string
      sql: ${TABLE}.sku ;;
      # action: {
      #   label: "Send a Thing"
      #   url: "https://example.com/ping/\{{ value }}"
      #   form_url: "https://example.com/ping/\{{ value }}/form.json"
      # }
    }


    measure: count {
      type: count_distinct
      sql: ${id} ;;
      drill_fields: [id]

      # link: {

      #   label: "Show as table"

      #   url: "

      #   {% assign vis_config = '{

      #   {\"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":12,\"rows_font_size\":12,\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"type\":\"looker_grid\",\"defaults_version\":1,\"series_types\":{},\"value_labels\":\"legend\",\"label_type\":\"labPer\",\"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"legend_position\":\"center\",\"point_style\":\"none\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"ordering\":\"none\",\"show_null_labels\":false,\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\"}

      #   }' %}

      #   {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=10"

      # }
    }
  }
