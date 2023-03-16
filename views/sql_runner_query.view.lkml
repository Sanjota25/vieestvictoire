view: sql_runner_query {
  derived_table: {
    sql: SELECT
          (TO_CHAR(TO_DATE(CONVERT_TIMEZONE('UTC', 'Asia/Tokyo', CAST(orders."CREATED_AT"  AS TIMESTAMP_NTZ))), 'YYYY-MM-DD')) AS "orders.created_date",
          orders."STATUS"  AS "orders.status",
          COUNT(DISTINCT 1=1 ) AS "orders.count"
      FROM "LOOKER_TEST_BACKUP"."ORDER_ITEMS"
           AS order_items
          WHERE
          {% condition created_date_field %} date {% endcondition %}
      LEFT JOIN orders ON (order_items."ID")=(orders."ID")
      GROUP BY
          (TO_DATE(CONVERT_TIMEZONE('UTC', 'Asia/Tokyo', CAST(orders."CREATED_AT"  AS TIMESTAMP_NTZ)))),
          2
      ORDER BY
          3 DESC
      FETCH NEXT 500 ROWS ONLY
       ;;
  }


dimension: created_date_field {
  type: date

}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}."id" ;;
  }

  # dimension: operation {
  #   type: string
  #   sql: ${TABLE}."operation" ;;
  # }

  # dimension: objects {
  #   type: string
  #   sql: ${TABLE}."objects" ;;
  # }

  # dimension: schedule {
  #   type: string
  #   sql: ${TABLE}."schedule" ;;
  # }

  # dimension: projection {
  #   type: string
  #   sql: ${TABLE}."projection" ;;
  # }

  # dimension: expressions {
  #   type: string
  #   sql: ${TABLE}."expressions" ;;
  # }

  set: detail {
    fields: [
      id
    ]
  }
}
