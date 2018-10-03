process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.config.devServer = {
  host: '0.0.0.0',
  port: 8080
}

module.exports = environment.toWebpackConfig()
