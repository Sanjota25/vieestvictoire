
view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

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
    sql: ${TABLE}.created_at ;;
  }

  filter: filter_on_field_to_hide {
    type: number
    sql: {% condition filter_on_field_to_hide %} ${created_year} {% endcondition %} ;;
  }

  parameter: from_date {
    type: date_time
  }

  parameter: start_date_param {
    label: "Start Date Param"
    type: date
  }

  dimension: start_date {
    type: date
    sql:{% parameter start_date_param %} ;;
    convert_tz: no
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;

      html: {% if value == 'complete' %}
              <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
            {% elsif value == 'pending' %}
              <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
            {% else %}
              <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
            {% endif %}
        ;;
    }



  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
      description:
      "{% if _explore._name == 'order_items' %}
      The user ID for the Order Items Explore
      {% elsif _explore._name == 'orders' %}
      The user ID for the orders explore Explore
      {% else %}
      The user ID
      {% endif %}"

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  #   html:
  #   {% if status._value == 'complete'  %}

  #   <p style="color: black; background-color: pink; font-size:100%; text-align:center">{{ rendered_value }}</p>

  #   {% elsif status._value == 'pending' %}

  #   <p style="color: black; background-color: black; font-size:100%; text-align:center">{{ rendered_value }}</p>

  #   {% else %}

  #   <p style="color: black; background-color: black; font-size:100%; text-align:center">{{ rendered_value }}</p>

  #   {% endif %}

  #   ;;
  # }


    html:
    {% if status._value == 'complete'  %}

    <section style="color: black; background-color: pink; font-size:100%; text-align:center">{{ linked_value }}</section>

    {% elsif status._value == 'pending' %}

    <section style="color: black; background-color: black; font-size:100%; text-align:center">{{ linked_value }}</section>

    {% else %}

    <section style="color: black; background-color: black; font-size:100%; text-align:center">{{ linked_value }}</section>

    {% endif %}

    ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
}
}
