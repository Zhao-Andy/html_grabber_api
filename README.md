# HTML Grabber API

This is a simple Rails API that can be used to grab `h1`, `h2`, `h3`, and `a` tags from any page. It uses the [Nokogiri gem](https://github.com/sparklemotion/nokogiri) to parse the HTML, and is hosted on Heroku: <https://html-grabber-api.herokuapp.com>

It runs on Rails 5 and has a PostgreSQL database.

## Usage Instructions

1. [Go to the app to get a key.](https://html-grabber-api.herokuapp.com)
2. Sign up with your email.
3. Place your key in an ENV variable to be accepted as a header.
4. Send a `POST` request to 
`https://html-grabber-api.herokuapp.com/parse`, with `url` parameters in the link. For example:  
`https://html-grabber-api.herokuapp.com/parse?url=https://zhao-andy.github.io`  
This grabs the HTML tags from that page.
5. To get data as JSON, send a `GET` request with your email and API key in the header. Headers are accepted like so:  
`Authorization` => `Token token=your_api_key`  
`X-User-Email` => `your_email@example.com`  
You can send to either the index route or the show route.  
For the index route, use:  
`https://html-grabber-api.herokuapp.com/index.json`  
For the show route, use:  
`https://html-grabber-api.herokuapp.com/show.json?url=your-specific-url`
You can also view the page itself as JSON using the same links.

If you ever forget your key or  you can simply [go back to the app home page](https://html-grabber-api.herokuapp.com) and login with your email.


## Contributing
Feel free to contribute! Simply fork and clone the repo.

