import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class BankDetailPage extends StatelessWidget {
  final dynamic bank; // Replace with your Bank model type

  const BankDetailPage({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.blue.shade700,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                bank.bankName ?? 'Bank Details',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.account_balance,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Stats Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.percent,
                                  title: 'Interest Rate',
                                  value: '${bank.interestRate}%',
                                  subtitle: bank.interestType ?? 'Fixed',
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.calendar_today,
                                  title: 'Tenure',
                                  value: '${bank.tenureYears}',
                                  subtitle: 'Years',
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.currency_rupee,
                                  title: 'Processing Fee',
                                  value: '₹${_formatAmount(bank.processingFee)}',
                                  subtitle: 'One-time',
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatCard(
                                  icon: Icons.credit_score,
                                  title: 'Min CIBIL',
                                  value: '${bank.minCibilScore}',
                                  subtitle: 'Required',
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contact Information
                  _SectionCard(
                    title: 'Contact Information',
                    icon: Icons.contact_phone,
                    children: [
                      _DetailRow(
                        icon: Icons.person,
                        label: 'Contact Person',
                        value: bank.contactName ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: bank.contactNumber ?? 'N/A',
                        trailing: bank.contactNumber != null
                            ? IconButton(
                                icon: const Icon(Icons.call, size: 20),
                                onPressed: () => _launchPhone(bank.contactNumber),
                                color: Colors.blue,
                              )
                            : null,
                      ),
                      _DetailRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: bank.email ?? 'N/A',
                        trailing: bank.email != null
                            ? IconButton(
                                icon: const Icon(Icons.email, size: 20),
                                onPressed: () => _launchEmail(bank.email),
                                color: Colors.blue,
                              )
                            : null,
                      ),
                      _DetailRow(
                        icon: Icons.language,
                        label: 'Website',
                        value: bank.websiteUrl ?? 'N/A',
                        trailing: bank.websiteUrl != null
                            ? IconButton(
                                icon: const Icon(Icons.open_in_browser, size: 20),
                                onPressed: () => _launchWebsite(bank.websiteUrl),
                                color: Colors.blue,
                              )
                            : null,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Branch Location
                  _SectionCard(
                    title: 'Branch Location',
                    icon: Icons.location_on,
                    children: [
                      _DetailRow(
                        icon: Icons.store,
                        label: 'Branch',
                        value: bank.branchName ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.home,
                        label: 'Address',
                        value: bank.locationAddress ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.place,
                        label: 'City',
                        value: bank.city ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.location_city,
                        label: 'State',
                        value: bank.state ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.pin_drop,
                        label: 'Postal Code',
                        value: bank.postalCode ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.flag,
                        label: 'Country',
                        value: bank.country ?? 'N/A',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Loan Details
                  _SectionCard(
                    title: 'Loan Details',
                    icon: Icons.account_balance_wallet,
                    children: [
                      _DetailRow(
                        icon: Icons.arrow_upward,
                        label: 'Max Loan Amount',
                        value: '₹${_formatAmount(bank.maxLoanAmount)}',
                      ),
                      _DetailRow(
                        icon: Icons.arrow_downward,
                        label: 'Min Loan Amount',
                        value: '₹${_formatAmount(bank.minLoanAmount)}',
                      ),
                      _DetailRow(
                        icon: Icons.currency_rupee,
                        label: 'Minimum Income',
                        value: '₹${_formatAmount(bank.minimumIncome)}',
                      ),
                      _DetailRow(
                        icon: Icons.work,
                        label: 'Employment Type',
                        value: bank.employmentType ?? 'N/A',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Eligibility Criteria
                  _SectionCard(
                    title: 'Eligibility Criteria',
                    icon: Icons.check_circle,
                    children: [
                      _DetailRow(
                        icon: Icons.cake,
                        label: 'Age Range',
                        value: '${bank.minimumAge} - ${bank.maximumAge} years',
                      ),
                      _DetailRow(
                        icon: Icons.public,
                        label: 'Nationality',
                        value: bank.nationalityRequirement ?? 'N/A',
                      ),
                      _DetailRow(
                        icon: Icons.credit_score,
                        label: 'Minimum CIBIL Score',
                        value: '${bank.minCibilScore}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Features
                  _SectionCard(
                    title: 'Features & Benefits',
                    icon: Icons.star,
                    children: [
                      _FeatureRow(
                        label: 'Prepayment Allowed',
                        isEnabled: bank.prepaymentAllowed ?? false,
                      ),
                      _FeatureRow(
                        label: 'Part Payment Allowed',
                        isEnabled: bank.partPaymentAllowed ?? false,
                      ),
                      _FeatureRow(
                        label: 'Balance Transfer Available',
                        isEnabled: bank.balanceTransferAvailable ?? false,
                      ),
                      _FeatureRow(
                        label: 'Insurance Bundled',
                        isEnabled: bank.insuranceBundled ?? false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Special Offers
                  if (bank.specialOffers != null && bank.specialOffers.isNotEmpty)
                    _SectionCard(
                      title: 'Special Offers',
                      icon: Icons.local_offer,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.celebration, color: Colors.amber.shade700),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    bank.specialOffers,
                                    style: TextStyle(
                                      color: Colors.amber.shade900,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  // Required Documents
                  if (bank.requiredDocuments != null && bank.requiredDocuments.isNotEmpty)
                    _SectionCard(
                      title: 'Required Documents',
                      icon: Icons.description,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            bank.requiredDocuments,
                            style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 16),

                  // Details
                  if (bank.details != null && bank.details.isNotEmpty)
                    _SectionCard(
                      title: 'Additional Details',
                      icon: Icons.info,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            bank.details,
                            style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double? amount) {
    if (amount == null) return 'N/A';
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} L';
    }
    return amount.toStringAsFixed(0);
  }

  void _launchPhone(String? phone) async {
    if (phone == null) return;
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail(String? email) async {
    if (email == null) return;
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWebsite(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.blue.shade700, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String label;
  final bool isEnabled;

  const _FeatureRow({
    required this.label,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            isEnabled ? Icons.check_circle : Icons.cancel,
            size: 20,
            color: isEnabled ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            isEnabled ? 'Yes' : 'No',
            style: TextStyle(
              fontSize: 12,
              color: isEnabled ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}