const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
    mode: 'development',
    entry: './src/scripts/app.js',
    output: {
        filename: 'app.js',
        path: path.resolve(__dirname, 'public_html/catalog/view/theme/app/bundle')
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery'
        }),
        new MiniCssExtractPlugin({
            filename: 'app.css'
        })
    ],
    module: {
        rules: [
            {
                test: require.resolve('jquery'),
                use:
                        [
                            {
                                loader: 'expose-loader',
                                options: 'jQuery'
                            },
                            {
                                loader: 'expose-loader',
                                options: '$'
                            }
                        ]
            },
            {
                test: /(\.scss|\.css)$/,
                use:
                        [
                            //просто формирует один файл из предыдущей цепочки лоадеров
                            MiniCssExtractPlugin.loader, 
                            //"style-loader",

                            //загружает css в style ноды, это шаг нужен для MiniCssExtractPlugin
                            //https://github.com/webpack-contrib/sass-loader#source-maps
                            {
                                loader: "css-loader",
                                options: {
                                    url: false,
                                    sourceMap: true
                                }
                            },

                            // compiles Sass to CSS, using Node Sass by default
                            {
                                loader: "sass-loader",
                                options: {
                                    sourceMap: true,
                                    outputStyle: "compressed"
                                }
                            }
                        ]
            }
        ]
    }
};
