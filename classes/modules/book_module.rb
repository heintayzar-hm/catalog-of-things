
class BookModule
    
    def initialize
        @books = []
    end

    attr_accessor :books

    def list_all_books
        puts "Books are: "
        # @books.each do |book|
        #     puts book
        # end
    end

#     def add_book
#         puts "Please enter the title of the book:"
#         title = gets.chomp
#         puts "Please enter the author of the book:"
#         author = gets.chomp
#         puts "Please enter the genre of the book:"
#         genre = gets.chomp
#         puts "Please enter the source of the book:"
#         source = gets.chomp
#         puts "Please enter the label of the book:"
#         label = gets.chomp
#         puts "Please enter the publish date of the book:"
#         publish_date = gets.chomp
#         puts "Please enter the archive status of the book:"
#         archive = gets.chomp
#     end
end