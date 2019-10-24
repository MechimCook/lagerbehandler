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

## goals
  * have different dashboards for each department
  * departments are sales, warehouse, admin, purchasing
  * purchasing will have auto-gen item ids based on standards set by admin and details about order, which will be tracked for future orders, and for other departments to use
  * admin will see stats, add users, modify/add databases
  * sales will see all details from purchasing, 'secure' products for clients from warehouse stock or for purchasing to order
  * warehouse will see orders expected orders, see warehouse stock in a map of warehouse made by warehouse admin 


## current todo
  * add department and admin field
  * repurpose /protected to admin view to add users
