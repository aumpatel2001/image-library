import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PaymentMethod { card, paypal }

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _paypalIdController = TextEditingController();
  final TextEditingController _paypalPasswordController = TextEditingController();

  bool _isProcessing = false;
  PaymentMethod _selectedMethod = PaymentMethod.card;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    _paypalIdController.dispose();
    _paypalPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildPaymentMethodSelector(),
                const SizedBox(height: 20),
                if (_selectedMethod == PaymentMethod.card)
                  Column(
                    children: [
                      _buildCardForm(),
                      const SizedBox(height: 30),
                      _buildCardNumberField(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildExpiryDateField()),
                          const SizedBox(width: 20),
                          Expanded(child: _buildCvvField()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildCardHolderField(),
                      const SizedBox(height: 40),
                    ],
                  )
                else
                  _buildPayPalForm(),
                _buildPayButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedMethod = PaymentMethod.card),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedMethod == PaymentMethod.card
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/Mastercard.png',
                            height: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text('Credit Card'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedMethod = PaymentMethod.paypal),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedMethod == PaymentMethod.paypal
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/paypel.png',
                            height: 40,
                          ),
                          const SizedBox(height: 8),
                          const Text('PayPal'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  'assets/chip.png',
                  height: 40,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberFormatter(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cardHolderController,
              decoration: const InputDecoration(
                labelText: 'Card Holder Name',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expiryDateController,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardExpiryFormatter(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayPalForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PayPal Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _paypalIdController,
              decoration: const InputDecoration(
                labelText: 'PayPal Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _paypalPasswordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberFormatter(),
      ],
      decoration: _buildInputDecoration('Card Number', Icons.credit_card),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter card number';
        }
        if (value.replaceAll(' ', '').length != 16) {
          return 'Card number must be 16 digits';
        }
        return null;
      },
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: _expiryDateController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardExpiryFormatter(),
      ],
      decoration: _buildInputDecoration('Expiry Date (MM/YY)', Icons.calendar_today),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter expiry date';
        }
        if (value.length != 5) {
          return 'Invalid date format';
        }
        return null;
      },
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: _buildInputDecoration('CVV', Icons.lock),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter CVV';
        }
        if (value.length != 3) {
          return 'CVV must be 3 digits';
        }
        return null;
      },
    );
  }

  Widget _buildCardHolderField() {
    return TextFormField(
      controller: _cardHolderController,
      decoration: _buildInputDecoration('Card Holder Name', Icons.person),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter card holder name';
        }
        return null;
      },
      onChanged: (value) => setState(() {}),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _isProcessing
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            _processPayment(context);
          }
        },
        child: _isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          _selectedMethod == PaymentMethod.paypal
              ? 'PAY WITH PAYPAL'
              : 'PAY NOW',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _processPayment(BuildContext context) async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isProcessing = false);
    _showPaymentConfirmation(context);
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_selectedMethod == PaymentMethod.paypal
                ? 'Your PayPal payment has been processed successfully.'
                : 'Your card payment has been processed successfully.'),
            const SizedBox(height: 10),
            if (_selectedMethod == PaymentMethod.card)
              Text(
                  'Card: •••• •••• •••• ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)}'),
            if (_selectedMethod == PaymentMethod.paypal)
              Text('PayPal ID: ${_paypalIdController.text}'),
            const Text('Amount: \$9.99'),
            Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String number) {
    if (number.length < 12) return '•••• •••• •••• ••••';
    final visiblePart = number.substring(number.length - 4);
    return '•••• •••• •••• $visiblePart';
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class CardExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('/', '');
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i != text.length - 1) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}