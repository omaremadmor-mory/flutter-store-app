import 'package:flutter/material.dart';
import 'package:viro_store2/screens/home_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<PayScreen> {
  final _formKey = GlobalKey<FormState>();
  String paymentMethod = "Visa";

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم الدفع بنجاح (محاكاة)"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("اختر وسيلة الدفع"),
              ListTile(
                title: const Text("Visa / MasterCard"),
                leading: Radio(
                  value: "Visa",
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() => paymentMethod = value.toString());
                  },
                ),
              ),
              ListTile(
                title: const Text("الدفع عند الاستلام"),
                leading: Radio(
                  value: "Cash",
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() => paymentMethod = value.toString());
                  },
                ),
              ),
              if (paymentMethod == "Visa") ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: "رقم البطاقة"),
                  validator: (value) =>
                      value!.isEmpty ? "أدخل رقم البطاقة" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "تاريخ الانتهاء",
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "أدخل تاريخ الانتهاء" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "CVV"),
                  validator: (value) =>
                      value!.isEmpty ? "أدخل كود الأمان" : null,
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: _processPayment,
                    child: const Text("Pay now"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
