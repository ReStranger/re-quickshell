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

    /**
     * Converts a normalized value into an integer percent (0..100).
     * Values outside the range are clamped; null/undefined becomes 0.
     *
     * @param {number} value - Normalized value.
     * @returns {number} Percent value in range 0..100.
     */
    function normalizedToPercent(value) {
        const n = Math.max(0, Math.min(1, value ?? 0));
        return Math.round(n * 100);
    }

    function formatSeconds(s) {
        const day = Math.floor(s / 86400);
        const hours = Math.floor(s / 3600) % 24;
        const minutes = Math.floor(s / 60) % 60;

        let comps = [];
        if (day > 0)
            comps.push(`${day}d`);
        if (hours > 0)
            comps.push(`${hours}h`);
        if (minutes > 0 || comps.length == 0)
            comps.push(`${minutes}m`);

        return comps.join(" ");
    }
}
