const mongoose = require('mongoose');

const searchSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    response: {
        type: String,
        required: true
    },
    searchParameter: [String],
    messageType: {
        type: String,
        enum: ['string', 'image', 'video']
      }
      , date: {
        type: Date,
        default: Date.now 
      }
});

module.exports = mongoose.model('Search', searchSchema);