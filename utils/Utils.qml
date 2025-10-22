pragma Singleton

import Quickshell

Singleton {
    id: root

    /**
     * Capitalizes the first letter of a string and converts the rest to lowercase.
     *
     * @param {string} string - The input string.
     * @returns {string} The string with the first letter capitalized.
     */
    function capitalize(string) {
        return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }
}
