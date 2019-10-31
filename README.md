# Lagerbehandler

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## databases

  * users
    * id
    * username(string)
    * departments(string)
    * admin(boolean)
    * password(hash)

  * orders
    * id
    * users(id)
    * quantities(int)
    * products(id)
    * venders(id)
    * purchasers(id)
    * order_date(date_time)
    * expected_delivery_date(date_time)
    * delivery_date(date_time)
    * purchase_date(date_time)

  * sales
    * id
    * users(id)
    * quantities(int)
    * products(id)
    * venders(id)
    * purchasers(id)
    * order_date(date_time)
    * expected_delivery_date(date_time)
    * delivery_date(date_time)
    * purchase_date(date_time)

  * products
    * id
    * name(string)
    * quantities(int)
    * costs(int)
    * venders(id)
    * purchasers(id)
    * sales(id)

  * venders
    * id
    * products(id)
    * quantities(int)
    * name(string)
    * contact([string])
    * sales(id)

  * purchasers
    * id
    * name(string)
    * sales(id)
    * orders(id)   
    * contact([string])



## goals
  * liveview for every view
  * have different dashboards for each department
  * departments are sales, warehouse, admin, purchasing

  * purchasing will
    * have auto-gen item ids based on standards set by admin and details about order, which will be tracked for future orders, and for other departments to use
    * see current sales that haven't been completed
    * see current stock
    * see current orders

  * admin will
    * see stats, add users, modify/add databases

  * sales will
    * see all details from purchasing to put together orders
    * 'secure' products for clients from warehouse stock or for purchasing to order
    * see previous sales

  * warehouse will
    * see orders expected orders
    * see warehouse stock in a map of warehouse made by warehouse admin


## current todo
  * create admin plug
  * modify form for departments to be a drop box and for admin to be checkbox
  * allow delete users on show page
