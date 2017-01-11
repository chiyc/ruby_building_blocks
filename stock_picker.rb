def stock_picker prices
  max_profit = -1
  buy_day = -1
  sell_day = -1

  prices.each_with_index do |buy_price, day_b| 
  	prices[day_b...prices.length].each.with_index(day_b) do |sell_price, day_s|
#  	  puts "Evaluating buy day #{day_b} and sell day #{day_s}"
  	  if sell_price - buy_price > max_profit
  	  	buy_day = day_b
  	  	sell_day = day_s
  	  	max_profit = sell_price - buy_price
  	  end
  	end
  end
  puts "Buy on day #{buy_day} and sell on day #{sell_day} for a max profit of #{max_profit}"
  return [buy_day, sell_day]
end


stock_picker([17,3,6,9,15,8,6,1,10])
stock_picker([5, 4, 3, 2, 1])
stock_picker([11, 6, 3, 4, 6, 1])