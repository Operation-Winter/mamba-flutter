import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static String route = '/privacy-policy';

  const PrivacyPolicyScreen({super.key});

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: maxWidth),
            child: ListView(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      top: 16, bottom: 8, left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 30,
                              icon: const Icon(Icons.chevron_left),
                            ),
                            const Expanded(
                              child: TitleText(
                                text: 'Mamba Privacy Policy',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        Html(
                          onAnchorTap:
                              (url, context, attributes, element) async =>
                                  await _launchUrl(url),
                          data: """
                            <h1>Privacy Policy</h1>
                            <p>Last updated: March 10, 2023</p>
                            <p>This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your
                                information
                                when You use the Service and tells You about Your privacy rights and how the law protects You.</p>
                            <p>We use Your Personal data to provide and improve the Service. By using the Service, You agree to the
                                collection and use of information in accordance with this Privacy Policy.
                            </p>
                            <h1>Interpretation and Definitions</h1>
                            <h2>Interpretation</h2>
                            <p>The words of which the initial letter is capitalized have meanings defined under the following conditions.
                                The following definitions shall have the same meaning regardless of whether they appear in singular or in
                                plural.
                            </p>
                            <h2>Definitions</h2>
                            <p>For the purposes of this Privacy Policy:</p>
                            <ul>
                                <li>
                                    <p><strong>Account</strong> means a unique account created for You to access our Service or parts of our
                                        Service.</p>
                                </li>
                                <li>
                                    <p><strong>Affiliate</strong> means an entity that controls, is controlled by or is under common control
                                        with a
                                        party, where &quot;control&quot; means ownership of 50% or more of the shares, equity interest or
                                        other
                                        securities entitled to vote for election of directors or other managing authority.</p>
                                </li>
                                <li>
                                    <p><strong>Application</strong> refers to Mamba, the software program provided by the Company.</p>
                                </li>
                                <li>
                                    <p><strong>Company</strong> (referred to as either &quot;the Company&quot;, &quot;We&quot;,
                                        &quot;Us&quot;
                                        or
                                        &quot;Our&quot; in this Agreement) refers to Mamba.</p>
                                </li>
                                <li>
                                    <p><strong>Country</strong> refers to: South Africa</p>
                                </li>
                                <li>
                                    <p><strong>Device</strong> means any device that can access the Service such as a computer, a cellphone
                                        or a
                                        digital tablet.</p>
                                </li>
                                <li>
                                    <p><strong>Personal Data</strong> is any information that relates to an identified or identifiable
                                        individual.
                                    </p>
                                </li>
                                <li>
                                    <p><strong>Service</strong> refers to the Application.</p>
                                </li>
                                <li>
                                    <p><strong>Service Provider</strong> means any natural or legal person who processes the data on behalf
                                        of
                                        the
                                        Company. It refers to third-party companies or individuals employed by the Company to facilitate the
                                        Service, to provide the Service on behalf of the Company, to perform services related to the Service
                                        or
                                        to
                                        assist the Company in analyzing how the Service is used.</p>
                                </li>
                                <li>
                                    <p><strong>Usage Data</strong> refers to data collected automatically, either generated by the use of
                                        the
                                        Service or from the Service infrastructure itself (for example, the duration of a page visit).</p>
                                </li>
                                <li>
                                    <p><strong>You</strong> means the individual accessing or using the Service, or the company, or other
                                        legal
                                        entity on behalf of which such individual is accessing or using the Service, as applicable.</p>
                                </li>
                            </ul>
                            <h1>Collecting and Using Your Personal Data</h1>
                            <h2>Types of Data Collected</h2>
                            <h3>Personal Data</h3>
                            <p>While using Our Service, We may ask You to provide Us with certain personally identifiable information that
                                can
                                be
                                used to contact or identify You. Personally identifiable information may include, but is not limited to:</p>
                            <ul>
                                <li>
                                    <p>First name and last name</p>
                                </li>
                                <li>
                                    <p>Usage Data</p>
                                </li>
                            </ul>
                            <h3>Usage Data</h3>
                            <p>Usage Data is collected automatically when using the Service.</p>
                            <p>Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser
                                type,
                                browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on
                                those
                                pages, unique device identifiers and other diagnostic data.</p>
                            <p>When You access the Service by or through a mobile device, We may collect certain information automatically,
                                including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP
                                address
                                of
                                Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device
                                identifiers and other diagnostic data.</p>
                            <p>We may also collect information that Your browser sends whenever You visit our Service or when You access the
                                Service
                                by or through a mobile device.</p>
                            <h2>Use of Your Personal Data</h2>
                            <p>The Company may use Personal Data for the following purposes:</p>
                            <ul>
                                <li>
                                    <p><strong>To provide and maintain our Service</strong>, including to monitor the usage of our Service.
                                    </p>
                                </li>
                            </ul>
                            <p>We may share Your personal information in the following situations:</p>
                            <ul>
                                <li><strong>For business transfers:</strong> We may share or transfer Your personal information in
                                    connection with,
                                    or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a
                                    portion of Our business to another company.</li>
                                <li><strong>With other users:</strong> when You share personal information or otherwise interact in the
                                    public areas
                                    with other users, such information may be viewed by all users and may be publicly distributed outside.
                                </li>
                                <li><strong>With Your consent</strong>: We may disclose Your personal information for any other purpose with
                                    Your consent.</li>
                            </ul>
                            <h2>Retention of Your Personal Data</h2>
                            <p>The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this
                                Privacy
                                Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal
                                obligations (for
                                example, if we are required to retain your data to comply with applicable laws), resolve disputes, and
                                enforce our legal agreements and policies.</p>
                            <p>The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for
                                a
                                shorter period of time, except when this data is used to strengthen the security or to improve the
                                functionality
                                of
                                Our Service, or We are legally obligated to retain this data for longer time periods.</p>
                            <h2>Transfer of Your Personal Data</h2>
                            <p>Your information, including Personal Data, is processed at the Company's operating offices and in any other
                                places
                                where the parties involved in the processing are located. It means that this information may be transferred
                                to —
                                and
                                maintained on — computers located outside of Your state, province, country or other governmental
                                jurisdiction
                                where
                                the data protection laws may differ than those from Your jurisdiction.</p>
                            <p>Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement
                                to
                                that
                                transfer.</p>
                            <p>The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in
                                accordance
                                with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a
                                country
                                unless there are adequate controls in place including the security of Your data and other personal
                                information.
                            </p>
                            <h2>Delete Your Personal Data</h2>
                            <p>You have the right to delete or request that We assist in deleting the Personal Data that We have collected
                                about You.</p>
                            <p>Our Service may give You the ability to delete certain information about You from within the Service.</p>
                            <p>You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one,
                                and visiting the account settings section that allows you to manage Your personal information. You may also
                                contact Us to request access to, correct, or delete any personal information that You have provided to Us.</p>
                            <p>Please note, however, that We may need to retain certain information when we have a legal obligation or
                                lawful
                                basis
                                to do so.</p>
                            <h2>Disclosure of Your Personal Data</h2>
                            <h3>Business Transactions</h3>
                            <p>If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We
                                will
                                provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.
                            </p>
                            <h3>Law enforcement</h3>
                            <p>Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so
                                by
                                law
                                or in response to valid requests by public authorities (e.g. a court or a government agency).</p>
                            <h3>Other legal requirements</h3>
                            <p>The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:</p>
                            <ul>
                                <li>Comply with a legal obligation</li>
                                <li>Protect and defend the rights or property of the Company</li>
                                <li>Prevent or investigate possible wrongdoing in connection with the Service</li>
                                <li>Protect the personal safety of Users of the Service or the public</li>
                                <li>Protect against legal liability</li>
                            </ul>
                            <h2>Security of Your Personal Data</h2>
                            <p>The security of Your Personal Data is important to Us, but remember that no method of transmission over the
                                Internet,
                                or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to
                                protect
                                Your
                                Personal Data, We cannot guarantee its absolute security.</p>
                            <h1>Children's Privacy</h1>
                            <p>Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable
                                information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your
                                child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data
                                from anyone under the age of 13 without verification of parental consent, We take steps to remove that
                                information from Our servers.</p>
                            <p>If We need to rely on consent as a legal basis for processing Your information and Your country requires
                                consent from
                                a parent, We may require Your parent's consent before We collect and use that information.</p>
                            <h1>Links to Other Websites</h1>
                            <p>Our Service may contain links to other websites that are not operated by Us. If You click on a third party
                                link, You
                                will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every
                                site You visit.</p>
                            <p>We have no control over and assume no responsibility for the content, privacy policies or practices of any
                                third party sites or services.</p>
                            <h1>Changes to this Privacy Policy</h1>
                            <p>We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new
                                Privacy Policy on this page.</p>
                            <p>We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming
                                effective and update the &quot;Last updated&quot; date at the top of this Privacy Policy.</p>
                            <p>You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy
                                are effective when they are posted on this page.</p>
                            <h1>Contact Us</h1>
                            <p>If you have any questions about this Privacy Policy, You can contact us by <a href="mailto:mamba.operation.winter@gmail.com">mamba.operation.winter@gmail.com</a></p>
                          """,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
