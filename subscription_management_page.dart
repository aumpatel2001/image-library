import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_page.dart';

class SubscriptionManagementPage extends StatefulWidget {
  const SubscriptionManagementPage({super.key});

  @override
  State<SubscriptionManagementPage> createState() => _SubscriptionManagementPageState();
}

class _SubscriptionManagementPageState extends State<SubscriptionManagementPage> {
  String _currentSubscription = 'Premium Plan';

  @override
  void initState() {
    super.initState();
    _loadCurrentSubscription();
  }

  Future<void> _loadCurrentSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentSubscription = prefs.getString('currentSubscription') ?? 'Premium Plan';
    });
  }

  Future<void> _updateSubscription(String selectedPlan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentSubscription', selectedPlan);
    setState(() {
      _currentSubscription = selectedPlan;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Subscription updated to $selectedPlan'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _changePaymentMethod() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentPage(),
      ),
    );
  }

  void _cancelSubscription() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Subscription'),
        content: const Text('Are you sure you want to cancel your subscription?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _updateSubscription('None');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Your subscription has been cancelled'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(
      BuildContext context,
      String title,
      String description,
      String price,
      String plan,
      List<String> features,
      ) {
    bool isSelected = _currentSubscription == plan;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: isSelected
            ? const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
          width: 1,
        ),
        color: isSelected ? null : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _updateSubscription(plan),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white70 : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: isSelected ? Colors.white70 : Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        feature,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Manage Subscription'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Subscription',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentSubscription,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Available Plans',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPlanOption(
                  context,
                  'Basic Plan',
                  'Essential features for casual users',
                  'Free',
                  'Basic Plan',
                  ['Limited image access', 'Basic search', 'Standard quality'],
                ),
                _buildPlanOption(
                  context,
                  'Standard Plan',
                  'Perfect for enthusiasts',
                  '\$5/month',
                  'Standard Plan',
                  ['Full image access', 'Advanced search', 'HD quality', 'Download options'],
                ),
                _buildPlanOption(
                  context,
                  'Premium Plan',
                  'Professional features',
                  '\$10/month',
                  'Premium Plan',
                  ['All Standard features', '4K quality', 'Priority support', 'No watermarks', 'Bulk downloads'],
                ),
                _buildPlanOption(
                  context,
                  'Ultimate Plan',
                  'Everything unlimited',
                  '\$20/month',
                  'Ultimate Plan',
                  ['All Premium features', 'API access', 'Custom categories', 'VIP support', 'Commercial license'],
                ),
                const SizedBox(height: 24),

                // Payment Method Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _changePaymentMethod,
                        icon: const Icon(Icons.payment, color: Colors.black),
                        label: const Text(
                          'Payment Method',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Cancel Subscription Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _cancelSubscription,
                        icon: const Icon(Icons.cancel, color: Colors.black),
                        label: const Text(
                          'Cancel Subscription',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
