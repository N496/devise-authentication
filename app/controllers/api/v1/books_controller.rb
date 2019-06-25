class Api::V1::BooksController < ApiController
  gem 'googlebooks', '~> 0.0.9'
  def search
    books = GoogleBooks.search(params[:q])
    @books = []
    books.each do |book|
      @books.push(
        {
          goodreadsId: book.id,
          title: book.title,
          authors: book.authors,
          covers: [
            book.image_link
          ],
          pages: book.page_count,
          preview_book: book.preview_link
        })
    end
    render json: {
      books: @books
    }
    # render json: {
    #   books: [
    #     {
    #       goodreadsId: 1,
    #       title: '1984',
    #       authors: 'Orwell',
    #       covers: [
    #         'https://michaelhyatt.com/images/book.cover.2D.004.jpg',
    #         'https://www.creativindie.com/wp-content/uploads/2013/10/cover-design-secrets-pinterest.jpg'
    #       ],
    #       pages: 198
    #     },
    #     {
    #       goodreadsId: 2,
    #       title: 'Three Men in a Boat',
    #       authors: 'Jerome K. Jerome',
    #       covers: [
    #         'https://fionajaydemedia.com/wp-content/uploads/2015/07/willowOfChangeFinal-FJM_Mid_Res_1000x15001.jpg',
    #         'https://www.creativindie.com/wp-content/uploads/2012/07/stock-image-site-pinterest-graphic.jpg'
    #       ],
    #       pages: 256
    #     },
    #   ]
    # }
  end

  def index
    books = current_user.books
    render json: {
      books: books
    }
  end

  def create
    book = current_user.books.new(book_params)
    if book.save
      render json: {
        book: book,
        message: 'Book created successfully'
      }
    end
  end
  private

  def book_params
    params.require(:book).permit(:title, :authors, :cover, :goodreadsId, :pages, :preview_book, :user_id)
  end
end
