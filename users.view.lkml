view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    group_label: "User Attributes"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    group_label: "Location"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    group_label: "Location"
    drill_fields: [state, city]
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

  dimension: days_since_signup {
    type: number
    sql: DATEDIFF('day', ${created_date}, GETDATE()) ;;
  }

  dimension: is_new_user {
    type: yesno
    sql: ${days_since_signup} <= 60 ;;
  }

  dimension: days_since_signup_tier {
    type: tier
    sql: ${days_since_signup} ;;
    tiers: [30, 60, 90, 180, 360, 720]
    style: integer
  }

  dimension: user_location {
    type: string
    sql: ${city} || ', ' || ${state} || ', ' || ${country} ;;
    group_label: "Location"
  }

  dimension: age_tier {
    type: tier
    sql: ${age} ;;
    tiers: [20, 25, 30, 45, 50]
    style: integer
  }

  dimension: is_under_25 {
    type: yesno
    sql: ${age} <= 25 ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    hidden: yes
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    group_label: "User Attributes"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    hidden: yes
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
    group_label: "User Attributes"
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
    group_label: "Location"
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
    group_label: "Location"
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    group_label: "Location"
    drill_fields: [city]
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

  set: user {
    fields: [id, full_name, age]
  }
}
