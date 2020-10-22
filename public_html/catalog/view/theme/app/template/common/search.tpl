<div id="search" class="search-form" itemscope="" itemtype="https://schema.org/WebSite">
    <meta itemprop="url" content="https://ant-snab.ru">
    <form itemprop="potentialAction" itemscope="" itemtype="https://schema.org/SearchAction" class="wrapper_search" action="/search" method="GET" >
        <meta itemprop="target" content="https://ant-snab.ru/search/?search={search}">
        <input itemprop="query-input" type="text" id="inputSearch" placeholder="Поиск" name="search" value="<?= $search ?>"/>
        <button data-search-url="<?= $search_url ?>" ></button>
        <input type="submit" class="hidden_button_search">
    </form>
</div>
<!--
<div itemscope="" itemtype="https://schema.org/WebSite">
    <meta itemprop="url" content="https://ant-snab.ru">
    <form itemprop="potentialAction" itemscope="" itemtype="https://schema.org/SearchAction">
        <meta itemprop="target" content="https://ant-snab.ru/search/?search={query}">
        <input itemprop="query-input" type="text" name="query" required="">
        <input type="submit">
    </form>
</div>
-->