board = [" "," "," "," "," "," "," "," "," "]

# WIN_COMBINATIONS shows the indexes of board that must be occupied by the same token for a win
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

# Define display_board that accepts a board and prints out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#input_to_index takes a user's input (from $stdin) and subtracts 1
def input_to_index(input)
  (input.to_i) - 1
end

#move accepts board, index, and char to change the board array to reflect a player's move
def move(board, index, char)
  board[index] = char
end

#position_taken will return false if an array indes is empty, indicating that the position is not taken
def position_taken?(board, index)
    if (board[index] == " " || board[index] == "" || board[index] == nil)
        false
    else
        true
    end
end

#valid_move will return true if the player has entered a position that is on the board, and if the position is not occupied
def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board,index)
    true
  end
end

#turn asks a player for input, checks to see if it is valid, and displays the board after a turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
    if valid_move?(board, index) == true
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
  end
end

#turn_count must keep track of what turn it is by counting the number of occupied possitions on the board array
#turn_count iterates over board, and adds 1 to count for each index that is not empty.
#note that we have used the `return` keyword at the end of the method so that the method returns the current value of count, rather than the array. The normal return value for #each is the original array.
def turn_count(board)
  count = 0
  board.each do |character|
    if character != " " && character != ""
      count += 1
    end
  end
  return count
end

#this method keeps track of whether it is an odd or even turn
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# The #won? method should return false if a board is empty, return the array if a win combination is met, and otherwise return false.
# Note that the final `return false` simply means that the default of the method is to return false. So, if none of the previous statements are met, it will get down to the last part of the method and return fale.
# Note also that my soloution is really long; the official solution is much shorter and more elegant.
def won?(board)
  if WIN_COMBINATIONS.each do |win_array|
    win_index_1 = win_array[0]
    win_index_2 = win_array[1]
    win_index_3 = win_array[2]
      if board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && board[win_index_1] == board[win_index_3] && board[win_index_1] != " "
        return win_array
      end
    end
  end
  return false
end

# The #full? method should accept a board and return true if every element in the board contains either an "X" or an "O".
def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

# The #draw? method accepts a board and returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.
def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

# The #over? method accepts a board and returns true if the board has been won, is a draw, or is full.
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

# The #winner method should accept a board and return the token, "X" or "O" that has won the game given a winning board.
def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

#play must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game
def play(board)
  until over?(board) == true
    turn(board)
  end
    if draw?(board)
      puts "Cats Game!"
    elsif winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
end
