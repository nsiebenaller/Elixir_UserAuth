defmodule MyApp.Post do
  use MyApp.Web, :model

  schema "posts" do
    field :message, :string
    belongs_to :user, MyApp.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message])
    |> validate_required([:message])
  end
end
