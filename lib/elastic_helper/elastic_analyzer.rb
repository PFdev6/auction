module ElasticMyAnalyzer
  ES_SETTING = {
    index: {
      number_of_shards: 1
    },
    analysis: {
      filter: {
        lots_stopwords: {
          type: 'stop',
          stopwords: ''},
        lots_nGram: {
          type: 'ngram',
          min_gram: 4,
          max_gram: 8
        }
      },
      analyzer: {
        user_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: [
            'lowercase', 'english_morphology', 'lots_stopwords', 'lots_nGram'
          ]
        }
      }
    }
  }
end
