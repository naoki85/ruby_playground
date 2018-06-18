const { dev_server: devServer } = require('@rails/webpacker').config
const ExtractTextPlugin = require('extract-text-webpack-plugin')

const isProduction = process.env.NODE_ENV === 'production'
const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))
//const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction
const extractCSS = false

const extractOptions = {
  fallback: 'style-loader',
  use: [
    { loader: 'css-loader', options: {
        minimize: isProduction,
        modules: true,
        localIdentName: '[path][name]__[local]--[hash:base64:5]'
      }
    },
    { loader: 'sass-loader', options: { sourceMap: true } }
  ]
}

// For production extract styles to a separate bundle
const extractCSSLoader = {
  test: /\.(scss|sass|css)$/i,
  use: ExtractTextPlugin.extract(extractOptions)
}

// For hot-reloading use regular loaders
const inlineCSSLoader = {
  test: /\.(scss|sass|css)$/i,
  use: ['style-loader'].concat(extractOptions.use)
}

module.exports = isProduction || extractCSS ? extractCSSLoader : inlineCSSLoader
