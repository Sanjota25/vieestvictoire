# Define the database connection to be used for this model.
connection: "snowflake_test"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: sanju_snowflake_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
include: "/views/**/*.view"



persist_with: sanju_snowflake_default_datagroup

explore: orders {}
explore: order_items {
  join: orders {
    relationship: many_to_one
    sql_on: ${order_items.id}=${orders.id} ;;
  }
  join: users {
    relationship: many_to_one
    sql_on: ${orders.id}=${users.id} ;;

  }
  # join: sql_runner_query {
  #   relationship: many_to_one
  #   sql_on: ${users.id}=${order_items_id } ;;

  # }
}
explore: sql_runner_query {
  join: orders {
    relationship: many_to_one
    sql_on: ${sql_runner_query.id}=${orders.id} ;;
  }
}
