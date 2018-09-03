const path = require('path');
const webpack = require('webpack');
module.exports = {
    mode: 'development',
    entry: './src/scripts/app.js',
    output: {
        filename: 'app.js',
        path: path.resolve(__dirname, 'public_html/catalog/view/javascript/app')
    },
    module: {
        rules: [{
                test: require.resolve('jquery'),
                use: [{
                        loader: 'expose-loader',
                        options: 'jQuery'
                    }, {
                        loader: 'expose-loader',
                        options: '$'
                    }]
            }]
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery'
        })
    ]
};
