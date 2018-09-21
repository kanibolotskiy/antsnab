const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = (env, options) => {
    return {
        mode:"development",
        watchOptions: {
            ignored: /node_modules/
        },
        optimization: {
            minimize: (options.mode === 'development') ? false : true,
        },
        devtool: (options.mode === 'development') ? "source-map" : false,
        entry: './src/scripts/app.js',
        output: {
            filename: 'app.js',
            path: path.resolve(__dirname, 'public_html/catalog/view/theme/app/bundle')
        },
        plugins: [
            new CleanWebpackPlugin(['public_html/catalog/view/theme/app/bundle']),
            new webpack.ProvidePlugin({
                $: 'jquery',
                jQuery: 'jquery'
            }),
            new MiniCssExtractPlugin({
                filename: 'app.css'
            })
        ],
        module: {
            noParse: function (content) {
                if (options.mode === 'development') {
                    return /jquery$|jcf.*|inputmask.*|opencart_product|easyResponsiveTabs/.test(content);
                }
                return false;
            },
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
                                outputStyle: (options.mode === 'development') ? "compact" : "compressed"
                            }
                        }
                    ]
                }
            ]
        }
    };
};
    
