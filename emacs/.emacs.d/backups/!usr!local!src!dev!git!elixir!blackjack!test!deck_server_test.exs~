defmodule DeckTest do
  alias Blackjack.DeckServer, as: DeckServer

	use ExUnit.Case

	setup do
		{:ok, pid} = DeckServer.start
		on_exit fn ->
			DeckServer.stop
		end
		:ok
	end

  test "that the deck has 52 cards" do
    assert DeckServer.remaining_cards == 52
  end
end
