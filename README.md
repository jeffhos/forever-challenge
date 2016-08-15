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
