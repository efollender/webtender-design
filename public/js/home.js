$("#ingredients").zmultiselect({
            live: "#live",
            placeholder: "Select your ingredients",
            filter: true,
            filterPlaceholder: 'Search by name',
            filterResult: true,
            filterResultText: "Showing",
            selectedText: ['Selected','of']
});
$("#common").zmultiselect({
    live: "#submit",
    placeholder: "Common ingredients",
    filter: true,
    filterPlaceholder: 'Search by name',
    filterResult: true,
    filterResultText: "Showing",
    selectedText: ['Selected','of']
});