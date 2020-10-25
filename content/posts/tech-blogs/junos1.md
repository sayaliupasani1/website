---
title: "Getting Started with Ansible for Juniper - Part 1"
date: 2020-10-16
hero: /images/posts/tech-blogs/junos.png
author: "Sayali Upasani"
menu:
  sidebar:
    name: Getting Started with Ansible for Junos - Part 1
    identifier: junos1
    parent: tech-blogs
    weight: 40
---

Hi ..

I recently had a wonderful oppportunity of working with Juniper High-End Firewalls and like an icing on the cake, to configure them as a code.
Although my "wonderful" may sound a bit sarcastic, it really is not.. well, at least not 100% because the path of IaaC was not as simple as I expected it to be :( The reason for that is not surprising though:
1. This was to be achieved in a time-constrained setting (and, if my past tells me anything, it is -- if you don't do it now, you will probably keep chasing time for it).
2. In my experience, the Ansible community is not as heavily involved on network automation as you may find it for Ubuntu/Linux or platform systems, yet.
3. Apart from knowing that these High-End firewalls look amazing with eye-catching SFP/QSFP ports and a giant HA port, I knew nothing! Basically, I just didn't have the hands-on experience with junos, let alone, the experience in codifying them (which, honestly was the most exciting!)

So, after a couple of months of my trials and tribulations, I got a successful deploy on our Junipers (Okay, its still not perfect) and I take great pride in sharing some details that I learnt the hard way!
That being said, Juniper portal has great knowledge base even for Ansible, that definitely helped in a lot of situations.

Without further ado, lets begin and I hope this blogs helps and saves you some hours of googling :)

I am writing this blog based on the major hurdles that I faced when developing Ansible tasks and playbooks for configuring Juniper Firewalls as a code. This blog will guide you in getting started and running your first playbook :)

As noted in the Ansible documentation, unlike most of the ansible modules, network modules don't run on the `managed` nodes since majority of the network devices cannot run python. Hence, the modules are executed on the `control` node. This is just something worth noting especially if you're like me and just starting out configuring network devices using ansible.

After you have followed all the set up of control node and juniper hosts (and all the shenanigans), you can jump to the below points for `junos` specifically.

## Python Requirements

Junos OS requires certain python dependencies installed on your control node. Its always a great idea to use a virtual environment and I have used `pyenv` for this. I preferred installing ansible in my virtualenv using `pip` as well.

Below dependencies were used:

```
- python 3.7.7
- python packages:
  - ansible==2.9.6
  - Jinja2==2.11.2
  - junos-eznc==2.5.2
  - jxmlease==1.0.3
  - lxml==4.5.2
  - ncclient==0.6.9
  - paramiko==2.7.1

```

You can simply save all the python package dependencies in a `requirements.txt` file and `pip install -r` that file.


## Junos Platform OS options

Junos OS supports multiple connections options, referenced in Ansible docs here: https://docs.ansible.com/ansible/2.9/network/user_guide/platform_junos.html

I used `netconf` as the connection option mainly because:

1. It is the recommended options (per ansible documentation)
2. The returned data format can be `json`
3. All the available junos modules can be used with netconf connection

The network details required for connecting to your junos can be specified in inventory file as below:

```
# inventory/hosts

[junos]

junos1 ansible_host=x.x.x.x
junos2 ansible_host=x.x.x.x

[junos:vars]
ansible_connection=netconf
ansible_port=830
ansible_network_os=junos
ansible_timeout=300 #This is required if your playbook takes longer to run and/or there are major network delays from your control node to managed host

```

You also need to specify `ansible_user` and `ansible_password` for connecting to your Juniper system. Its best to put that in a separate variable file and `vault encrypt` it.
Or, you can always setup your Juniper user for ansible to use SSH key based authentication and get rid of the `ansible_password` altogether.

## Ansible Galaxy Modules for Junos OS

Apart from the core ansible modules for junos, Juniper Networks provides [`juniper.junos`](https://galaxy.ansible.com/Juniper/junos) ansible role, which exists at Ansible Galaxy.
There are certain enhanced set of modules that exists in this role, for which, you need to install it on your control node.

To install, simply run: `ansible-galaxy install juniper.junos` on your control node.

Or, you can get creative here too and have a playbook below that installs the role on your control node (especially helpful if your control node is not localhost):

```
- name: Install roles on local machine
  hosts: localhost
  connection: local
  gather_facts: no

  tasks:
    - name: Install roles as per requirements.yml
      command: ansible-galaxy install --roles-path <path to where roles are installed> -r <path to requirements.yml>
      
```

where `requirements.yml` includes junos and all the other necessary roles that you'd like to exist on your control node. 
For `juniper.junos`, below works:

```
# requirements.yml

# Installing juniper.junos role
- src: juniper.junos
  version: 2.3.1
  
```


## Enabling netconf

Junos OS does **not** have `netconf` enabled by default. Hence, if you choose to use `netconf` as your protocol of choice, you need to enable `netconf` before running any ansible adhoc command or playbook.

You can enable `netconf` by running this simple playbook against your junos hosts:

```
---
- name: Configuring netconf
  hosts: junos
  gather_facts: no
  connection: network_cli #This playbook will use a different connection type

  tasks:
    - name: Enable netconf on the juniper OS
      junos_netconf:
        listens_on: 830 # this is default netconf port. You can change this if required
        state: present

```
> Note the connection that we use here is network_cli

Once this task runs successfully, you are ready to test your first ansible `adhoc` command against juniper.
I usually prefer running a quick ping to verify the connectivity: `ansible junos -i <inventory path> -m ping`
If you see a `pong` in the output of this...yayyy!!! If not, well, first thing I would do is check any existing firewall between control node and juniper! (netconf `port 830` is just scary for firewalls until you specify otherwise :))

## Gotchas to Note

Before you begin developing your playbooks, here are some gotchas that I wish I knew about beforehand:

1. Juniper modules **don't** exist for each and every configuration, especially for firewalls. So, be prepared to get creative with the existing ones. [Jinja templating](https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html) comes in handy and helps developing comprehensive tasks, so try and get yourself acquainted with it.
2. Spend some time getting familiar with `Junos CLI`. This will help configuring tasks that are lacking in ansible modules (and its always a good idea to know how things work manually!).
3. For all the tasks/playbooks, its best to think what elements can qualify as variables and separating those out into a separate `vars` file. You can include relevant variable files in your playbook using `vars_files` with list of files. 
4. A general thumb rule is, you should not need to update your playbook's/task's source code. Anything that might need modifications based on changes to be deployed, should go in as a variable. 
5. With security policies/ACLs and NAT policies, the variable files start getting massive. Its best to plan scalibility in advance.
6. If you are an Ansible beginner, take sometime understanding Ansible loops and options around those. 
Refer: https://docs.ansible.com/ansible/2.9/user_guide/playbooks_loops.html
7. Use [Ansible tags](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html) at every possible task/block. With your playbooks growing, you will soon see their major contribution in making your future self happier!


## Setting up Juniper FW Basic Configurations

If you achieved that `pong` and are ready for getting some actual configurations on your Juniper Firewalls, its always a great idea to begin with some basic configurations that are required for any networking device.

I guess, we can try the following for this:

1. Change/ Update Firewall's hostname
2. DNS server (esp since you can use FQDN address objects in your security policies)
3. NTP settings (please, never forget this little guy!)

### Configuring Name servers and Hostname

To configure hostname and name servers, you can leverage `junos_system` as below:

```
- name: configure domain name for Juniper
      junos_system:
        domain_name: "{{ domainname }}" #This is how you call a variable in ansible. This can exist in a separate vars file, which can be called in the playbook
        state: present
      tags:
       - domainname

    - name: Configure name servers
      junos_system:
        name_servers:
          - "{{ item }}" #This will loop over list of name servers
        state: present
      with_items:
        - "{{ list_of_name_servers }}" #Define this list with all name servers as elements in vars file
      tags:
        - name_servers
 
```

### Configuring NTP servers

I could not find a specific junos modules that would provide easier way of adding NTP servers, so had to use `junos_config` for this as:

Note for NTP on Junos:

1. If you specify NTP servers FQDN, at the time of configuration, Juniper resolves the fqdn and adds the IP into configuration
2. Hence, re-running the playbook leads to change most of the times as the IP of NTP server changes (unless you have just one NTP server). The new IP gets appended to the list of NTP servers.


```

  - name: Configure NTP servers on Juniper
      junos_config:
        lines:
          - set system ntp server "{{ item }}" # loops over list of NTP servers
          - set system time-zone {{ time_zone }}
        update: merge
      with_items:
        - "{{ list_of_ntp_servers }}"# Define this list with all NTP servers as elements in vars file)
      
```

### Validating your output

You can choose to cram all the above tasks into as single playbook and run it to get basic stuff setup on your firewall :)
To verify your changes in a proactive manner, you can have a task with `junos_command` executing relevant `show` commands and displaying outputs that can manually verified at the end of playbook run. Or, use ansible's `assert` and `that`. 
An example of that is below:

```
- name: Gather NTP status
      junos_command:
        commands: show ntp status
      register: ntp_status
      

 - name: Validate changes
      assert:
        that:
          - "'status' in ntp_status['stdout_lines'][0][0]"

```

The assertion will pass if the output of `show ntp status` contains `status` keyword in it. You can use this for other validations based on what is expected in a successful output.
This method just saves time on manually verifying displayed output and we all can agree that it feels amazing when your playbook itself tells you that "All Assertions have Passed" in nice green letters :)


I guess this marks the end of our Part 1! You have successfully configured your Juniper device using Ansible!
At this point, you are free to go crazy and try out different junos modules!

Our next part will go further into developing more firewall specific playbooks and also clustering two junos instances in HA! Stay tuned!
