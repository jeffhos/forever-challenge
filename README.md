# Forever Challenge
Please create a fork of this project and fulfill the requirements below.  Upon completion, please send Forever a link to your fork.

If you need to make an assumption about a vague requirement, feel free to do so, but please state that assumption at the bottom of this Readme.  Try to fulfill all of the requirements as if this application is going to be deployed into the real world with heavy usage.


# Requirements
1. Add basic API actions (index, show, create, update and destroy) to the albums_controller and photos_controller.
2. The albums index actions should return JSON with all available fields for the record AND a field for the total number of photos in the album.
3. The API index actions should use pagination with a max of 10 items per page and accept a param to iterate through pages.
4. An album's show action should return data for each photo in the album.
5. Ensure that every album has a name.
6. Ensure that every photo record belongs to an album, has a name and a url that ends with the string ".jpeg" or ".jpg".
7. Ensure that no more than 60 photos can be added to an album.
8. Create or modify a controller action so that multiple photos can be added to an album from one request.
9. Ensure that an album's average_date field is always the average taken_at date of all associated photos (or nil if the album has no photos).


# Bonus (only for senior developers)
1. Allow the API to add videos to an album.  The album index action should return a combination of photos and videos.
2. Allow photos to be added to multiple albums.


# Tech Specs
Rails 4.2.6

SQLite is preferred. Postgres is ok.

Anything can be changed if you think it's needed, including the gemfile, database schema, configs, etc.


# Getting Started
Run `bundle install` and `rake db:migrate`.

You can populate your database with fake data by running `rake db:seed`.

# My Forever Challenge Solution

## Pagination
When `index` documents for both photos and albums are returned, they are returned a maximum of 10 at a time; if there are more items, the document will contain a `next` key, with a path to fetch the next 10.  The second and subsequent pages will contain a `prev` key linking to the previous page as well.

## Multi-Photo Upload
For the multi-photo requirement (#8), I added a new resource, "batch" to handle batch photo creation.  It accepts an array of photo objects under the key `photos`:


```json
{
  "photos": [
    {
      "name": "Photo 1",
      . . .
    },
    {
      "name": "Photo 2",
      . . .
    }
  ]
}
```

It returns an array, with an entry for each corresponding entry in the request document.  Each entry contains a `status` key, with either the string "success" if the photo was successfully created, or "error" if it was not.  If it was successful, the created photo will be returned under the `photo` key in the document; if not, the list of errors will be returned under the `error` key:

```json
[
  {
    "result": "success",
    "photo": {
      "id": 2561,
      . . .
    }
  },
  {
    "result": "error",
    "errors": {
      "name": [
        "can't be blank"
      ]
    }
  }
]
```
