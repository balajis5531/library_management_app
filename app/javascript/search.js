document.addEventListener('DOMContentLoaded', function () {
  const bookSearchInput = document.getElementById('bookSearch');
  const searchResultsContainer = document.getElementById('search_result');

  if (bookSearchInput && searchResultsContainer) {
      
      fetch('/search')
          .then(response => response.json())
          .then(books => {
              bookSearchInput.addEventListener('input', function () {
                  const searchQuery = this.value.trim().toLowerCase();
                  const searchResults = books.filter(book => book.name.toLowerCase().includes(searchQuery));

                  displayResults(searchResults);
              });
          })
          .catch(error => console.error('Error fetching book data:', error));
  }

  function displayResults(results) {

      searchResultsContainer.innerHTML = '';
      searchResultsContainer.style.display = "block";

      if (results.length === 0) {
          searchResultsContainer.innerHTML = 'No results found.';
          return;
      }

      results.forEach(book => {
        const card = document.createElement("div");
        card.setAttribute("class", "card4");
      
        const name = document.createElement("a");
        name.setAttribute(
          "href",
          `books/${book.id}}`
        );
        name.innerText = book.name;
        card.appendChild(name);

        searchResultsContainer.appendChild(card);
      });
  }    
});