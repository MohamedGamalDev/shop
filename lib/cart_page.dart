import 'dart:async';
import 'package:flutter/material.dart';
import 'order.dart';
import 'package:provider/provider.dart';
import 'SettingsProvider.dart';
import 'app_theme.dart';

class CartPage extends StatefulWidget {
  static const String route = 'CartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Timer _timer;
  int _start = 1800;
  bool _isTimerRunning = false;
  bool _isOrderDelivered = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
      _start = 1800;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _showFeedbackOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate Your Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How would you rate the delivery?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(Icons.star, color: Colors.yellow),
                    onPressed: () {
                      // Handle rating logic here
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ),
              Text('Did your order arrive on time?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Yes" feedback
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thank you for your feedback!')));
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "No" feedback
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please provide your contact number.')));
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderItem> selectedItems = ModalRoute.of(context)!.settings.arguments as List<OrderItem>;
    final provider = Provider.of<SettingsProvider>(context);
    double totalPrice = selectedItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double deliveryFee = 20.0;
    double finalTotal = totalPrice + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                provider.isDark ? AppTheme.white : AppTheme.darkPrimary,
                provider.isDark ? AppTheme.gray : AppTheme.lightPrimary.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppTheme.darkPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              provider.isDark ? AppTheme.white : AppTheme.lightPrimary,
              provider.isDark ? AppTheme.gray : AppTheme.darkPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            Text(
              'Time Remaining: ${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (_start > 0 && !_isOrderDelivered)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isOrderDelivered = true;
                  });
                  _showFeedbackOptions();
                },
                child: Text('Order Arrived Before Time'),
              ),
            SizedBox(height: 20),
            ...selectedItems.map((item) {
              return ListTile(
                title: Text(item.productName),
                subtitle: Text('Quantity: ${item.quantity} - Price: \$${item.price * item.quantity}'),
              );
            }).toList(),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Delivery Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              maxLength: 11,
            ),
            SizedBox(height: 20),
            Text('Total: \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
            Text('Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            Text('Final Total: \$${finalTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Payment Method', style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PaymentOptionButton(paymentMethod: 'Cash'),
                SizedBox(width: 10),
                PaymentOptionButton(paymentMethod: 'Balance'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_addressController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
                  _startTimer();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter address and phone number.')));
                }
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionButton extends StatelessWidget {
  final String paymentMethod;

  const PaymentOptionButton({Key? key, required this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(paymentMethod),
      selected: false,
      onSelected: (selected) {

      },
    );
  }
}
