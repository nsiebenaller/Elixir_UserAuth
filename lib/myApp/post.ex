defmodule MyApp.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Post


  schema "posts" do
    field :message, :string
    field :user_id, :id

    

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:message])
    |> validate_required([:message])
    |> assoc_constraint(:user)
  end
end
