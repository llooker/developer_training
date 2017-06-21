connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: users {
  description: "This explore is based on the user table"
  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
    relationship: one_to_one
  }
}

explore: order_items {
  fields: [ALL_FIELDS*, -order_items.avg_spend_per_user]
  join: users {
    fields: [user*]
    sql_on:${order_items.user_id} = ${users.id} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
    relationship: one_to_one
  }
}
