/*<script>
    // Add smooth scrolling and enhanced interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add loading animation delay to sections
        const sections = document.querySelectorAll('.section, .stat-card');
        sections.forEach((section, index) => {
            section.style.animationDelay = `${index * 0.1}s`;
        });

        // Add click effects to buttons
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                // Create ripple effect
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.5);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                `;
                
                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Add hover effects to table rows
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px)';
            });
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });

        // Real-time clock in header (optional enhancement)
        function updateClock() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            const clockElement = document.getElementById('clock');
            if (clockElement) {
                clockElement.textContent = timeString;
            }
        }
        
        // Update clock every second if element exists
        if (document.getElementById('clock')) {
            setInterval(updateClock, 1000);
            updateClock();
        }
    });

    // CSS for ripple animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes ripple {
            to {
                transform: scale(2);
                opacity: 0;
            }
        }
        
        .fade-in {
            opacity: 0;
            animation: fadeIn 0.5s ease-in forwards;
        }
        
        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }
    `;
    document.head.appendChild(style);
</script>
*/

$(document).ready(function () {
    // Add loading animation delay to sections
    $('.section, .stat-card').each(function (index) {
        $(this).css('animation-delay', (index * 0.1) + 's');
    });

    // Add click ripple effect to buttons
    $('.btn').on('click', function (e) {
        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;

        const $ripple = $('<span></span>').css({
            position: 'absolute',
            width: size + 'px',
            height: size + 'px',
            left: x + 'px',
            top: y + 'px',
            background: 'rgba(255, 255, 255, 0.5)',
            borderRadius: '50%',
            transform: 'scale(0)',
            animation: 'ripple 0.6s ease-out',
            pointerEvents: 'none'
        });

        $(this).css({
            position: 'relative',
            overflow: 'hidden'
        }).append($ripple);

        setTimeout(function () {
            $ripple.remove();
        }, 600);
    });

    // Add hover effects to table rows
    $('tbody tr').hover(
        function () { $(this).css('transform', 'translateX(5px)'); },
        function () { $(this).css('transform', 'translateX(0)'); }
    );

    // Real-time clock in header
    function updateClock() {
        const now = new Date();
        const timeString = now.toLocaleTimeString();
        $('#clock').text(timeString);
    }

    if ($('#clock').length) {
        setInterval(updateClock, 1000);
        updateClock();
    }
});
