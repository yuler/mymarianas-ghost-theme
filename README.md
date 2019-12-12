# Custom

Ghost 3.1.1

## Update

core/frontend/helpers/navigation.js

```patch
diff --git a/core/frontend/helpers/navigation.js b/core/frontend/helpers/navigation.js
index fed5c02..aba670c 100644
--- a/core/frontend/helpers/navigation.js
+++ b/core/frontend/helpers/navigation.js
@@ -79,6 +79,19 @@ module.exports = function navigation(options) {
         return out;
     });

+    // custom format navigation
+    var index = 0
+    var output_format = {}
+    output_format = _.groupBy(output, function(item) {
+        if (!item.label.includes('=>')) {
+            index++
+        } else {
+            output_format[index].items = (output_format[index].items || []).push(item)
+        }
+        return index
+    })
+    output = output_format
+
     // CASE: The navigation helper should have access to the navigation items at the top level.
     this.navigation = output;
     // CASE: The navigation helper will forward attributes passed to it.
```