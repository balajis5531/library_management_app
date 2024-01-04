
document.addEventListener('DOMContentLoaded', function () {
    const books = <%=Book.all.to_json%>; // Assuming @books is an array of book objects
  
    const bookSearchInput = document.getElementById('bookSearch');
    const searchResultsContainer = document.getElementById('searchResults');
  
    if (bookSearchInput && searchResultsContainer) {
      bookSearchInput.addEventListener('input', function () {
        const searchQuery = this.value.trim().toLowerCase();
        const searchResults = books.filter(book => book.name.toLowerCase().includes(searchQuery));
  
        displayResults(searchResults);
      });
    }
  
    function displayResults(results) {
      searchResultsContainer.innerHTML = '';
  
      if (results.length === 0) {
        searchResultsContainer.innerHTML = 'No results found.';
        return;
      }
  
      results.forEach(book => {
        const bookElement = document.createElement('div');
        bookElement.textContent = book.name; // You can customize this to display other book details
        searchResultsContainer.appendChild(bookElement);
      });
    }
  });