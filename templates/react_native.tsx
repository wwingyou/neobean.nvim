/* This file is written
 *   by: {{_author_}}
 *   at: {{_date_}}
 *   contact: {{_email_}}
 * */
import { View, Text, StyleSheet } from "react-native";

export default function Page() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}></Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
  },
});
