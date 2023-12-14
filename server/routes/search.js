const express = require('express');
const router = express.Router();
const Search = require('../models/search');
const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://ediyiechrispopcorn:pZI379MS5Erxgv5s@cluster0.jkjlou1.mongodb.net/?retryWrites=true&w=majority');


router.post('/', (req, res, next) => {
  const search = new Search({
    _id: new mongoose.Types.ObjectId(),
    response: req.body.response,
    searchParameter: req.body.searchParameter,
    messageType: req.body.messageType,
  });

  search.save().then(result => {
    console.log(result);
    res.status(201).json({
      message: "Search Saved",
      addedSearch: search
    });

  }
  ).catch(error => {
    res.status(500).json({
      error: "Internal Error, Please try again later."
    })
  });

});


router.get('/', (req, res, next) => {
  const { name } = req.query;
  const searchName = name.toLowerCase().split(',');
  Search.find({
    searchParameter: { $regex: new RegExp(searchName, "i") }
  }).then((results) => {
    if (results.length === 0) {
      res.status(404).json({
        message: 'No Results found'
      });
    }
    else {
      res.status(200).json({ resultfound: results.length, matchingResults: results });
    }
  }).catch(error => { console.log(error) });

});


// router.get('/', (req, res, next) => {
//     const { name } = req.query;
//     const findResult = name.toLowerCase().split(',');
//     Search.find({
//         searchParameter: {$in: findResult}
//     }).then((response) => {
//         if(response.length === 0){
//             res.status(404).json({
//                 message: "No Results Found"
//             });
//         } else {
//             res.status(200).json({
//                 results: response
//             })
//         }
//     }).catch((error) => {
//         res.status(500).json({
//             message: "System Failure, Please Try Again Later."
//         });
//     });
// });

module.exports = router;