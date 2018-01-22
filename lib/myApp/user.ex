defmodule MyApp.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.User


  schema "users" do
    field :bio, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean, default: false, null: false

    has_many :posts, MyApp.Post

    timestamps()
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:name, :email, :bio])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end


  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end


end
