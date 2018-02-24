defmodule Blackjack.DeckServer do
	use GenServer

	#interface functions
	def start do
		GenServer.start(Blackjack.DeckServer, nil, name: Deck)
	end

	def stop do
		GenServer.call(:Deck, :stop)
	end

	#callbacks
	def init(_) do
		{:ok, deck}
	end

	def handle_call(:stop, _from, deck) do
		{:stop, :normal, :ok, deck}
	end


	defp deck do
    for suite <- [:spades, :hearts, :clubs, :diamonds],
		rank <-  [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine,
							:ten, :jack, :queen, :king], do: {suite, rank}
  end

  def shuffle_deck(deck) do
    :random.seed(:os.timestamp)
    Enum.shuffle(deck)
  end

  def deal_card([head|tail]) do
    {[head], tail}
  end

  def deal(deck, nr_of_cards) do
    deal([], deck, nr_of_cards)
  end

  defp deal(hand, deck, 0) do
    {hand, deck}
  end
  defp deal(hand, [], _) do
     {hand, []}
  end
  defp deal(hand, deck, nr_of_cards) do
    {card, remaining_deck} = deal_card(deck)
    deal(hand ++ card, remaining_deck, nr_of_cards - 1)
  end

  def display_card({suit, rank}) do
    IO.puts("The #{Atom.to_string(rank)} of #{Atom.to_string(suit)}")
  end

  def show(hand) do
    Enum.each(hand, fn card -> display_card(card) end)
  end

  def prepare_deck() do
    deck |> shuffle_deck
  end

end
