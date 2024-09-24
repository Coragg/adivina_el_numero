#=
This is a simple game where you only have to say: less, equal or greater than the number that appears on the screen.
=#

function instructions()
    println("This is a simple game where you only have to say: less, equal or greater than the number that appears on the screen.")
end


function create_question_and_variable_string(phrase:: String)
    #=This function is used to create a print and have an input in the process.
    =#
    print("$phrase")
    return readline()
end


create_list_of_numbers() = [number for number in 1:100] # create a list of numbers from 1 to 100


give_the_average(list_of_numbers:: Array{Int64,1}) = trunc(Int8, sum(list_of_numbers)/length(list_of_numbers)) # give the average of the list of numbers and give you the result in Int8


function cut_list(user_answer:: String, list_of_numbers:: Array{Int64,1}, average:: Int8)
    if  lowercase(user_answer) == "less"
        return [number for number in list_of_numbers if number < average]
    elseif  lowercase(user_answer) == "great"
        return [number for number in list_of_numbers if number > average]
    end
end


function generate_cut_with_answer(list_with_numbers:: Array{Int64,1}, round)
    average = give_the_average(list_with_numbers)
    user_answer = create_question_and_variable_string("$round) Is the number less, equal or greater than $average? (less/equal/great): ")
    if lowercase(user_answer)  == "less" || lowercase(user_answer) == "great"
        list_with_numbers = cut_list(user_answer, list_with_numbers, average)
        generate_cut_with_answer(list_with_numbers, round + 1)
    elseif lowercase(user_answer) == "equal"
        println("The number is $average, COOL")
        return
    else
        println("Please, enter a valid option.")
        generate_cut_with_answer(list_with_numbers, round)
    end
end


function game()
    start_or_exit_game = create_question_and_variable_string("Do you want to start the game? (y/n): ")
    set_numbers = create_list_of_numbers()
    if lowercase(start_or_exit_game)  == "y" || lowercase(start_or_exit_game) == "yes"
        println("Let's start!")
        generate_cut_with_answer(set_numbers, 1)
        game()
    elseif lowercase(start_or_exit_game) == "n" || lowercase(start_or_exit_game) == "no"
        println("Bye! \nSee you later.")
        exit()
    else
        println("Please, enter a valid option.")
        game()
    end
end


function main()
    instructions()
    game()
end


main()
