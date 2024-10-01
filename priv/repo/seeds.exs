# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StoreApi.Repo.insert!(%StoreApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
%StoreApi.Accounts.User {
  name: "Admin",
  email: "admin@email.com",
  role: "admin",
  password: Pbkdf2.hash_pwd_salt("Admin123!")
}
|> StoreApi.Repo.insert!()
